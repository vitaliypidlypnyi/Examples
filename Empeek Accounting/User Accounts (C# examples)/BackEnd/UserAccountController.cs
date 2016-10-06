using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using Empeek.Accounting.Common;
using Empeek.Accounting.Common.Constants.Enums;
using Empeek.Accounting.Core.Services;
using Empeek.Accounting.Model.ViewModels;

namespace Empeek.Accounting.Controllers
{
    [Authorize]
    public class UserAccountController : ApiController
	{
		private readonly IAuthenticationService _authenticationService;
		private readonly ITeamworkSyncService _teamworkSyncService;
        private readonly ITransactionService _transactionService;
        private readonly IUserAccountService _userAccountService;

		public UserAccountController(ITeamworkSyncService teamworkSyncService, IUserAccountService userAccountService, ITransactionService transactionService, IAuthenticationService authenticationService)
		{
			_authenticationService = authenticationService;
			_teamworkSyncService = teamworkSyncService;
		    _transactionService = transactionService;
            _userAccountService = userAccountService;
		}

        [AuditTrail("Get user accounts")]
		[Route("users")]
		[HttpGet]
		public HttpResponseMessage Get(bool getActive)
		{
			var accounts = _userAccountService.GetUserAccounts(AppSettings.TeamworkCompanyId, getActive);
			var accountViewModels = accounts.Select(account => new UserAccountViewModel(account));

			return Request.CreateResponse(HttpStatusCode.OK, accountViewModels);
		}

        [AuditTrail("Sync users")]
        [AuthorizeRoles(RoleType.Admin)]
        [Route("users/sync")]
		[HttpGet]
		public async Task<HttpResponseMessage> Sync()
		{
			var result = await _teamworkSyncService.SyncUsers(_authenticationService.UserId??0);

			return result.RequestStatus == RequestStatus.Success
				? Request.CreateResponse(HttpStatusCode.OK, result.Obj)
				: Request.CreateErrorResponse(HttpStatusCode.BadRequest, result.Message);
		}

        [AuditTrail("Get user info")]
        [Route("users/{id}")]
		[HttpGet]
		public HttpResponseMessage Get(int id)
		{
			var account = _userAccountService.GetUserById(id);
			var accountViewModels = new UserInfoViewModel(account);

			return Request.CreateResponse(HttpStatusCode.OK, accountViewModels);
		}

        [AuditTrail("Update user info")]
        [Route("users")]
		[HttpPut]
		public HttpResponseMessage Put(UserInfoViewModel userInfo)
		{
			if (!_authenticationService.HasAccess(userInfo.UserId, RoleType.Admin, RoleType.UserManager))
				return Request.CreateErrorResponse(HttpStatusCode.Forbidden, "Not allowed");

            return HandlAuthorizedUpdateUserRequest(userInfo);
		}
        [AuditTrail("Update user hire date")]
        [Route("users/HireDate")]
        [AuthorizeRoles(RoleType.Admin)]
        [HttpPut]
        public HttpResponseMessage UpdateHireDate(UserHireDateViewModel userHireDateModel)
        {
            return HandlAuthorizedUpdateUserRequest(userHireDateModel);
        }

        [AuditTrail("Update user english level")]
        [Route("users/EnglishLevel")]
        [AuthorizeRoles(RoleType.Admin, RoleType.UserManager)]
        [HttpPut]
        public HttpResponseMessage UpdateEnglishLevel(UserEnglishLevelViewModel userEnglishLevelModel)
        {
            return HandlAuthorizedUpdateUserRequest(userEnglishLevelModel);
		}

	    [AuditTrail("Get user Activity report")]
	    [Route("users/activityReport/{id}")]
	    [HttpGet]
	    public HttpResponseMessage GetActivityReport(int id)
	    {
            if (!_authenticationService.HasAccess(id, RoleType.Admin))
                return Request.CreateErrorResponse(HttpStatusCode.Forbidden, "Not allowed");

            var activityReport = _userAccountService.GetUserActivityReport(id);
            return Request.CreateResponse(HttpStatusCode.OK, activityReport);
        }

        [AuditTrail("Get user monthly earnings")]
        [Route("users/monthlyEarnings/{id}")]
        [HttpGet]
        public HttpResponseMessage GetMonthlyEarnings(int id)
        {
            if (!_authenticationService.HasAccess(id, RoleType.Admin))
                return Request.CreateErrorResponse(HttpStatusCode.Forbidden, "Not allowed");

            var monthlyEarnings = _transactionService.GetUserMonthlyEarnings(id).ToList();
            var result = new {monthlyEarnings, sum = monthlyEarnings.Sum(m => m.Salary)};
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [AuditTrail("Toggle user active")]
        [AuthorizeRoles(RoleType.Admin)]
		[Route("users/active/{id}")]
		[HttpGet]
		public HttpResponseMessage ToggleActive(int id)
		{
			_userAccountService.ToggleActive(id, _authenticationService.UserId??0);

			return Request.CreateResponse(HttpStatusCode.OK);
		}

        [AuditTrail("Change user password", ContainsPassword = true)]
        [Authorize]
		[Route("users/pass")]
		[HttpPut]
		public HttpResponseMessage ChangePassword(PasswordViewModel newPassword)
		{
			if (!_authenticationService.HasAccess(newPassword.UserId, RoleType.Admin))
				return Request.CreateErrorResponse(HttpStatusCode.Forbidden, "Not allowed");

			_userAccountService.ChangePassword(newPassword, _authenticationService.UserId??0);
			return Request.CreateResponse(HttpStatusCode.OK, true);
		}

        private HttpResponseMessage HandlAuthorizedUpdateUserRequest(UserInfoViewModel userInfoViewModel)
        {
            _userAccountService.UpdateInfo(userInfoViewModel, _authenticationService.UserId??0);

            return Request.CreateResponse(HttpStatusCode.OK);
        }
	}
}