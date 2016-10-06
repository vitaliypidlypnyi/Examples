using System.Collections.Generic;
using System.Threading.Tasks;
using Empeek.Accounting.Common.RequestResult;
using Empeek.Accounting.Model.Models.Invoice;
using Empeek.Accounting.Model.ViewModels;

namespace Empeek.Accounting.Core.Services
{
    public interface ITeamworkSyncService
    {
        Task<RequestResult<List<InvoiceHeader>>> SyncInvoices(int modifiedByUserId);
        Task<RequestResult<List<UserAccountViewModel>>> SyncUsers(int modifiedByUserId);
    }
}