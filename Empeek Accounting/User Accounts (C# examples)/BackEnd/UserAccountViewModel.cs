using System.Collections.Generic;
using Empeek.Accounting.Model.Models.Account;

namespace Empeek.Accounting.Model.ViewModels
{
    public class UserAccountViewModel
    {
        public UserAccountViewModel()
        {
            
        }

        public UserAccountViewModel(UserAccount userAccount)
        {
            SetFrom(userAccount);
        }
		
        public int Id { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
		public bool IsActive { get; set; }

        public List<TimeEntryViewModel> TimeLogs { get; set; }
        private void SetFrom(UserAccount userAccount)
        {
            Id = userAccount.Id;
            FullName = userAccount.FirstName + " " + userAccount.LastName;
            Email = userAccount.EmailAddress;
			PhoneNumber = userAccount.PhoneNumberMobile;
            IsActive = userAccount.IsActive;

            if (userAccount.TimeLogs != null)
            {
                TimeLogs = new List<TimeEntryViewModel>();
                foreach (var item in userAccount.TimeLogs)
                {
                    TimeLogs.Add(new TimeEntryViewModel(item));
                }
            }
        }
    }
}