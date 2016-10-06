using Empeek.Accounting.Common.Constants.Enums;
using Empeek.Accounting.Model.Models.Account;
using Empeek.Accounting.Repository.DataBase;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;

namespace Empeek.Accounting.Repository
{
	public class UserAccountRepository : RepositoryAudit<UserAccount>
    {
	    private readonly string UserWorkedHoursQuery = @"            
             SELECT ISNULL(SUM(ii.DecimalHours), 0) as TotalWorkedHours
               FROM dbo.userAccount ua 
			   LEFT JOIN dbo.InvoiceItem as ii ON ua.TeamWorkId = ii.TeamWorkUserId
			  WHERE ua.Id = @userId
			  GROUP BY ua.id";

        public UserAccountRepository(EmpeekDbContext db) : base(db)
        {
        }

        public UserAccount GetUserById(int userId)
        {
            return _db.UserAccount
				.Include(u => u.UserRoles.Select(r => r.Role))
				.Include(u => u.UserPaymentMethods.Select(p => p.PaymentMethod))
				.Include(u => u.UserPayments.Select(p => p.Payment))
				.FirstOrDefault(u => u.Id.Equals(userId));
        }

		public UserAccount GetUserByEmail(string email)
		{
			return _db.UserAccount
				.Include(u => u.UserRoles.Select(r => r.Role))
				.Include(u => u.UserPaymentMethods.Select(p => p.PaymentMethod))
				.Include(u => u.UserPayments.Select(p => p.Payment))
				.FirstOrDefault(u => u.EmailAddress.Equals(email));
		}

		public int GetIdByEmail(string email)
		{
			return _db.UserAccount
				.Where(u => u.EmailAddress.Equals(email))
				.Select(u => u.Id)
				.FirstOrDefault();
		}

		public UserAccount GetByTeamWorkId(int teamWorkId)
        {
            return _db.UserAccount
				.Include(i => i.UserPaymentMethods
				.Select(p => p.PaymentMethod))
				.FirstOrDefault(a => a.TeamWorkId.Equals(teamWorkId));
        }

		public IEnumerable<UserAccount> GetByCompanyId(int companyId, bool getActive)
        {
            return _db.UserAccount.Where(user => user.CompanyId == companyId && user.IsActive == getActive).ToList();
        }

        public IEnumerable<UserAccount> GetAll()
        {
            return _db.UserAccount.Include(a => a.TimeLogs).ToList();
        }

        public IEnumerable<UserAccount> GetByRoles(IEnumerable<RoleType> roles) {
            var roleNames = roles.Select(v => v.ToString());
            return _db.UserAccount.Where(u => u.UserRoles.Any(r => roleNames.Contains(r.Role.Name))).ToList();
        }

        public virtual void Delete(UserAccount entityToDelete)
        {
            if (_db.Entry(entityToDelete).State == EntityState.Detached)
            {
                _db.UserAccount.Attach(entityToDelete);
            }
            _db.UserAccount.Remove(entityToDelete);
        }

	    public decimal GetUserWorkedHours(int userId)
	    {
	        return _db.Database.SqlQuery<decimal>(UserWorkedHoursQuery,
	            new SqlParameter("@userId", userId)).FirstOrDefault();
	    }

	    protected override UserAccount Update(UserAccount entity)
	    {
	        return entity;
	    }

	    protected override UserAccount Save(UserAccount entity)
	    {
	        return entity;
	    }
    }
}
