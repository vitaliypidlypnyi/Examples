using System.Collections.Generic;
using System.Threading.Tasks;
using Empeek.Accounting.Common.RequestResult;
using Empeek.Accounting.Core.Integration.Teamwork;
using Empeek.Accounting.Model.Models.Invoice;
using Empeek.Accounting.Model.ViewModels;

namespace Empeek.Accounting.Core.Services.Impl
{
    public class TeamworkSyncService : ITeamworkSyncService
    {
        private readonly ITeamworkDataProvider _teamworkProvider;
        private readonly IInvoiceService _invoiceService;
        private readonly IUserAccountService _userAccountService;

        public TeamworkSyncService(ITeamworkDataProvider teamworkDataProvider, IInvoiceService invoiceService, IUserAccountService userAccountService)
        {
            _teamworkProvider = teamworkDataProvider;
            _invoiceService = invoiceService;
            _userAccountService = userAccountService;
        }

        public async Task<RequestResult<List<InvoiceHeader>>> SyncInvoices(int modifiedByUserId)
        {
            var invoices = await _teamworkProvider.GetActiveInvoices();
            var result = await _invoiceService.SyncInvoices(invoices, modifiedByUserId);

            return result;
        }

        public async Task<RequestResult<List<UserAccountViewModel>>> SyncUsers(int modifiedByUserId)
        {
            var users = await _teamworkProvider.GetUserAccounts();
            var result = await _userAccountService.CreateAccounts(users, modifiedByUserId);

            return result;
        }
    }
}