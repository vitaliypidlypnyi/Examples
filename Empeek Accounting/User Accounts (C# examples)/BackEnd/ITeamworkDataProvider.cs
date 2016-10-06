using System.Collections.Generic;
using System.Threading.Tasks;
using Empeek.Accounting.Model.Models.Account;
using Empeek.Accounting.Model.Models.Invoice;

namespace Empeek.Accounting.Core.Integration.Teamwork
{
    public interface ITeamworkDataProvider
    {
        Task<List<InvoiceHeader>> GetActiveInvoices();
        Task<List<UserAccount>> GetUserAccounts();
    }
}