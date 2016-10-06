$(function () {
    refreshColorPickers();
});

function refreshColorPickers() {
    $('.status-color-picker').colorpicker('destroy');
    $('.status-color-picker').colorpicker({
        customClass: 'colorpicker-2x',
        sliders: {
            saturation: {
                maxLeft: 150,
                maxTop: 150
            },
            hue: {
                maxTop: 150
            },
            alpha: {
                maxTop: 150
            }
        }
    }).on('changeColor', function (event) {
        $(this).closest('i').css('border', 'none');
        $(this).closest('i').css('background-color', event.color.toHex());
    });
};

function updateStatusesOrder() {
    var collection = [];
    $('.job-status-list-item').each(function (index, value) {
        if ($(value).attr('job-status-id')>0) {
            var idOrderItem = {
            id: $(value).attr('job-status-id'),
            order_number: parseInt($(value).attr('data-retouchable-eq')) + 1
        };
        collection.push(idOrderItem);
        }
    });
    sendRequest('/settings/UpdateJobStatusesOrder/', 'POST', { statusCollection: collection });
};

function sendRequest(url, type, object, successCallback, errorCallback) {
    if (!errorCallback) {
        errorCallback = function () {
            showTopErrorMessage();
        }
    }
    $.ajax({
        url: url,
        type: type,
        data: $.toDictionary(object),
        success: successCallback,
        error: errorCallback
    });
};

$('#add-status-button').click(function () {
    var lastStatusItem = $('.job-status-list-item').last();
    var template = lastStatusItem.clone();
    template.hide().appendTo('.retouchable-area');
    template.attr('job-status-id', 0);
    template.attr('data-retouchable-eq', parseInt(lastStatusItem.attr('data-retouchable-eq')) + 1);
    template.find('i').css('background-color', '#ffffff').css('border', '1px solid #b4b4b4');
    template.find('i').find('input:text').val('#ffffff');
    template.find('.job-status-name').val('').prop('disabled', false);
    template.find('.status-description').remove();
    if (template.find('.delete-status-button').length === 0) {
        var deleteLink = '<a class="anchor-link font10 delete-status-button pos-abs ml10" style="bottom: 5px"><img src="/assests/images/Rejected.png"></a>';
        template.find('.status-container').append(deleteLink);
    }
    template.find('.delete-status-button').click(deleteStatus);
    refreshColorPickers();
    template.slideDown(1000, function () { });
});

$('#reset-job-statuses').click(function () {
    checkForStatusReAssigning(resetJobStatuses);
});

function resetJobStatuses(oldStatusIds, newStatusIds) {
    var url = '/settings/resetjobstatuses';
    var type = 'GET';
    var data = { oldsTatusIds: oldStatusIds, newStatusIds: newStatusIds }
    var successCallback = function () { location.reload(); }
    sendRequest(url, type, data, successCallback);
}

function deleteStatus(id, replacementId) {
    if (isNaN(id) || id === 0) {
        $(this).closest('.job-status-list-item').slideUp(1000, function () { $(this).closest('.job-status-list-item').remove() });
    } else {
        var url = '/settings/deleteJobStatus';
        var type = 'POST';
        var data = { id: id, replacementId: replacementId };
        var suceessCallback = function () {
            $('.job-status-list-item[job-status-id=' + id + ']').slideUp(1000, function () { $(this).closest('.job-status-list-item').remove() });
        }
        sendRequest(url, type, data, suceessCallback);
    }
}

$('.delete-status-button').click(function () {
    var id = $(this).closest('.job-status-list-item').attr('job-status-id');
    checkForStatusReAssigning(deleteStatus, id);
});

function checkForStatusReAssigning(callback, callbackParam) {
    var url = '/settings/getNonRequiredJobStatuses';
    var type = 'GET';
    var successCallback = function (response) {
        if (response.length > 0) {
            buildRequiredStatusesSelectTemplate(response, callbackParam);
        } else {
            if (callbackParam) {
                callback(callbackParam);
            } else {
                callback();
            }
        }
    }
    sendRequest(url, type, callbackParam ? { particularStatusId: callbackParam } : {}, successCallback);
}

function buildRequiredStatusesSelectTemplate(reassignings, statusToDeleteId) {
    var url = '/settings/GetPossibleReplacementStatuses';
    var type = 'GET';
    var data = reassignings.map(function (a) { return a.id; });
    var successCallback = function (response) {
        var template = '<select class="font00 font-bold reassign-select"' + status.id + '">';
        for (var i = 0; i < response.length; i++) {
            template += '<option value="' + response[i].id + '">' + response[i].custom_name + '</option>';
        }
        template += ' </select><i></i>';
        $('#reassigning-div').html('');
        for (var j = 0; j < reassignings.length; j++) {
            $('#reassigning-div').append(getReassigningItem(reassignings[j], template));
        }
        assignSaveButtonClick(statusToDeleteId);
        $('.popup-shadow').show();
        $('#reset-statuses-popup').show();
        scrollTopElement($('#reset-statuses-popup'));
    };
    sendRequest(url, type, { deletingStatusIds: data, resetting: statusToDeleteId === undefined }, successCallback);
}

function getReassigningItem(status, requiredStatusesSelectTemplate) {
    var template = '<div class="dis-iblock job-status-list-item status-to-reassign no-bottom-padding" style="width:100%"><div class="dis-iblock status-container fleft" style="width:48%;">';
    template += '<i class="mr5 mb3 dis-iblock status-circle" style="background-color: ' + status.color + '"></i>';
    template += '<div class="dis-iblock ellipsis" style="max-width:59%"><span class="font-semi-bold"> ' + status.custom_name + ' </span></div><span class="status-arrow" style="font-size: 55px; font-weight: bold; float: right; margin-top: -27px">&#8594;</span></div>';
    template += '<input type="hidden" value=" '+ status.id +' "/>';
    template += '<div class="gr-br-sec mt5 dis-iblock fright" style="width:48%; margin-top: -6px">' + requiredStatusesSelectTemplate + '</div></div>';
    return template;
}

function assignSaveButtonClick(statusToDeleteId) {
    if (statusToDeleteId) {
        $('#reset-statuses').hide();
        $('#delete-status').unbind('click');
        $('#delete-status').click(function () {
            deleteStatus(statusToDeleteId, $('.reassign-select').val());
            popupCloser('reset-statuses-popup');
        });
        $('#delete-status').show();
        
    } else {
        $('#delete-status').hide();
        $('#reset-statuses').unbind('click');
        $('#reset-statuses').click(function () {
            var oldStatusIds = [], newStatusIds = [];
            $('.status-to-reassign').each(function (index, value) {
                oldStatusIds.push($(value).find('input[type="hidden"]').val());
                newStatusIds.push($(value).find('select').val());
            });
            resetJobStatuses(oldStatusIds, newStatusIds);
            popupCloser('reset-statuses-popup');
        });
        $('#reset-statuses').show();
    }
}

$('#save-job-statuses').click(function () {
    var statuses = [];
    $('.job-status-list-item').each(function (index, value) {
        var status = {
            id: $(value).attr('job-status-id'),
            custom_name: $(value).find('.job-status-name').val(),
            color: $(value).find('.status-color-picker').val(),
            order_number: parseInt($(value).attr('data-retouchable-eq'))
        }
        statuses.push(status);
    });
    var url = '/settings/updateStatuses';
    var type = 'POST';
    var data = { statuses: statuses };
    var successCallback = function () {
        location.reload();
    }
    var errorCallback = function () {
        showTopErrorMessageWithMessage('Error while saving statuses');
    }
    sendRequest(url, type, data, successCallback, errorCallback);
});
$('#reset-system-statuses-names').click(function() {
    sendRequest('/settings/resetSystemStatusNames', 'GET', {}, function() { location.reload(); });
});
function showResetStatusesPopup() {
    $('.popup-shadow').show();
    $('#reset-statuses-popup').show();
    scrollTopElement($('#reset-statuses-popup'));
};