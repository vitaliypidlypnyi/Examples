using System.Collections.Generic;
using System.Threading.Tasks;
using Empeek.Accounting.Common.Constants.Enums;
using Empeek.Accounting.Common.RequestResult;
using Empeek.Accounting.Model.Models.Account;
using Empeek.Accounting.Model.ViewModels;

namespace Empeek.Accounting.Core.Services
{
	public interface IUserAccountService
	{
		IEnumerable<UserAccount> GetUserAccounts(int companyId, bool getActive);
		Task<RequestResult<List<UserAccountViewModel>>> CreateAccounts(List<UserAccount> userAccount, int modifiedByUserId);
		UserAccount GetUserById(int id);
		UserAccount GetUserByEmail(string email);
		int GetIdByEmail(string email);
		void UpdateInfo(UserInfoViewModel info, int modifiedByUserId);
		void ToggleActive(int userId, int modifiedByUserId);
		void ChangePassword(PasswordViewModel newPass, int modifiedByUserId);
        UserActivityReportViewModel GetUserActivityReport(int userId);
        IEnumerable<UserAccount> GetUsersByRoles(params RoleType[] roles);
    }
}