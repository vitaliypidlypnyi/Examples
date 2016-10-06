using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Empeek.Accounting.Common.Constants.Enums;
using Empeek.Accounting.Common.Enciption;
using Empeek.Accounting.Common.RequestResult;
using Empeek.Accounting.Model.Models.Account;
using Empeek.Accounting.Model.Models.Invoice;
using Empeek.Accounting.Model.Models.Logger;
using Empeek.Accounting.Model.ViewModels;
using Empeek.Accounting.Common.InversionOfControls;
using Empeek.Accounting.Repository.UOW;

namespace Empeek.Accounting.Core.Services.Impl
{
    public class UserAccountService : IUserAccountService
	{
		private readonly ILogService _logLogService;

		public UserAccountService(ILogService logService)
		{
			_logLogService = logService;
		}
		
		public IEnumerable<UserAccount> GetUserAccounts(int companyId, bool getActive)
		{
			using (var uow = Ioc.Get<IUnitOfWork>())
			{
				return uow.UserAccountRepository.GetByCompanyId(companyId, getActive);
			}
		}

		public UserAccount GetUserById(int id)
		{
			using (var uow = Ioc.Get<IUnitOfWork>())
			{
				return uow.UserAccountRepository.GetUserById(id);
			}
		}

		public UserAccount GetUserByEmail(string email)
		{
			using (var uow = Ioc.Get<IUnitOfWork>())
			{
				return uow.UserAccountRepository.GetUserByEmail(email);
			}
		}

		public int GetIdByEmail(string email)
		{
			using (var uow = Ioc.Get<IUnitOfWork>())
			{
				return uow.UserAccountRepository.GetIdByEmail(email);
			}
		}

		public void UpdateInfo(UserInfoViewModel userInfo, int modifiedByUserId)
		{

			using (var uow = Ioc.Get<IUnitOfWork>())
			{
				var user = uow.UserAccountRepository.GetUserById(userInfo.UserId);
                userInfo.UpdateEntity(user);
                uow.UserAccountRepository.Update(user, modifiedByUserId);
				uow.Save();
			}
		}

		public void ToggleActive(int userId, int modifiedByUserId)
		{
			using (var uow = Ioc.Get<IUnitOfWork>())
			{
				var user = uow.UserAccountRepository.GetUserById(userId);
				user.IsActive = !user.IsActive;

				uow.UserAccountRepository.Update(user, modifiedByUserId);
				uow.Save();
			}
		}

		public void ChangePassword(PasswordViewModel newPass, int modifiedByUserId)
		{
			using (var uow = Ioc.Get<IUnitOfWork>())
			{
				var user = uow.UserAccountRepository.GetUserById(newPass.UserId);

				user.Password = Md5Hash.GetMd5Hash(newPass.Password);

				uow.UserAccountRepository.Update(user, modifiedByUserId);
				uow.Save();
			}
		}

	    public UserActivityReportViewModel GetUserActivityReport(int userId)
	    {
	        using (var uow = Ioc.Get<IUnitOfWork>())
	        {
	            var userAccountRepository = uow.GetAuditRepositoryOfType<UserAccount>();
	            var invoiceItemRepository = uow.GetAuditRepositoryOfType<InvoiceItem>();

	            var userWithItems = userAccountRepository
	                .Select()
                    .Where(x => x.Id == userId)
	                .Join(invoiceItemRepository.Select(), account => account.TeamWorkId, item => item.TeamWorkUserId,
	                    (account, item) => item)
                        .ToList();

                return new UserActivityReportViewModel()
	            {
                    HoursWorkedPreviousMonth = userWithItems.Where(x => x.DateLoggedUtc.Month == (DateTime.Now.Month -1) && x.DateLoggedUtc.Year == DateTime.Now.Year).Sum(x => x.DecimalHours),
                    HoursWorkedThisMonth = userWithItems.Where(x => x.DateLoggedUtc.Month == DateTime.Now.Month  && x.DateLoggedUtc.Year == DateTime.Now.Year).Sum(x => x.DecimalHours),
                    HoursWorkedTotal = userWithItems.Sum(x => x.DecimalHours)
                };
	        }
	    }

        public IEnumerable<UserAccount> GetUsersByRoles(params RoleType[] roles)
        {
            using (var uow = Ioc.Get<IUnitOfWork>())
            {
                var userRoles = uow.GetAuditRepositoryOfType<UserRole>().GetAll().Where(ur=> roles.ToList().Contains((RoleType)ur.RoleId));
                var users = uow.GetAuditRepositoryOfType<UserAccount>().GetAll().Where(acc => userRoles.Select(u => u.UserAccountId).ToList().Contains(acc.Id));
                return users;
            }
        }

        public async Task<RequestResult<List<UserAccountViewModel>>> CreateAccounts(List<UserAccount> userAccounts, int modifiedByUserId)
		{
			var result = new RequestResult<List<UserAccountViewModel>> {Obj = new List<UserAccountViewModel>()};
			using (var uow = Ioc.Get<IUnitOfWork>())
			{
				var dbUserAccounts = uow.UserAccountRepository.GetAll().ToList();

				userAccounts = userAccounts.Where(t => !dbUserAccounts.Select(u => u.TeamWorkId).Contains(t.TeamWorkId)).ToList();

				try
				{
					if (!userAccounts.Any())
					{
						result.RequestStatus = RequestStatus.Error;
						result.Message = "no NEW users to add to database";
						return result;
					}
					foreach (var account in userAccounts)
					{
						result.Obj.Add(new UserAccountViewModel(uow.UserAccountRepository.Save(account, modifiedByUserId)));
					}
					uow.Save();
					result.RequestStatus = RequestStatus.Success;
				}
				catch (Exception ex)
				{
					result.RequestStatus = RequestStatus.Error;
					result.Message = "error while creating new user account";
					_logLogService.Log(result.Message, ex, MessageType.Error);
				}
			}
			return await Task.FromResult(result);
		}
	}
}