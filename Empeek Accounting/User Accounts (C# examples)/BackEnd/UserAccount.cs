using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using Empeek.Accounting.Common.Constants.Enums;
using Empeek.Accounting.Model.Models.Payments;
using Newtonsoft.Json;
using Empeek.Accounting.Model.Models.Project;

namespace Empeek.Accounting.Model.Models.Account
{
	public class UserAccount : AuditEntity
	{
		public UserAccount()
		{
			TimeLogs = new List<TimeEntry>();
		}

		[JsonProperty("address-city")]
		public string AddressCity { get; set; }

		[JsonProperty("address-country")]
		public string AddressCountry { get; set; }

		[JsonProperty("address-line-1")]
		public string AddressLine1 { get; set; }

		[JsonProperty("address-line-2")]
		public string AddressLine2 { get; set; }

		[JsonProperty("address-state")]
		public string AddressState { get; set; }

		[JsonProperty("administrator")]
		public bool Administrator { get; set; }

		[JsonProperty("avatar-url")]
		public string AvatarUrl { get; set; }

		[JsonProperty("company-id")]
		public int CompanyId { get; set; }

		[JsonProperty("company-name")]
		public string CompanyName { get; set; }

		[JsonProperty("created-at")]
		public DateTime CreatedAt { get; set; }

		[JsonProperty("deleted")]
		public bool Deleted { get; set; }

		[JsonProperty("email-address")]
		public string EmailAddress { get; set; }

		[JsonProperty("first-name")]
		public string FirstName { get; set; }

		[JsonProperty("has-access-to-new-projects")]
		public bool HasAccessToNewProjects { get; set; }

		public override int Id { get; set; }

		[JsonProperty("im-handle")]
		public string ImHandle { get; set; }

		[JsonProperty("im-service")]
		public string ImService { get; set; }

		[JsonProperty("in-owner-company")]
		public bool InOwnerCompany { get; set; }

		public bool IsActive { get; set; }

		[JsonProperty("last-changed-on")]
		public DateTime? LastChangedOn { get; set; }

		[JsonProperty("last-login")]
		public DateTime? LastLogin { get; set; }

		[JsonProperty("last-name")]
		public string LastName { get; set; }

		[JsonProperty("login-count")]
		public int LoginCount { get; set; }

		[JsonProperty("notes")]
		public string Notes { get; set; }

		[JsonProperty("openId")]
		public int? OpenId { get; set; }

		public string Password { get; set; }

		[JsonProperty("phone-number-home")]
		public string PhoneNumberHome { get; set; }

		[JsonProperty("phone-number-mobile")]
		public string PhoneNumberMobile { get; set; }

		[JsonProperty("phone-number-office")]
		public string PhoneNumberOffice { get; set; }

		[JsonProperty("pid")]
		public int? Pid { get; set; }

		[JsonProperty("site-owner")]
		public bool SiteOwner { get; set; }

		[JsonProperty("tags")]
		public List<string> Tags { get; set; }

		[JsonProperty("id")]
		public int TeamWorkId { get; set; }

		[JsonProperty("textFormat")]
		public string TextFormat { get; set; }

		public List<TimeEntry> TimeLogs { get; set; }

		[JsonProperty("title")]
		public string Title { get; set; }

		[JsonProperty("twitter")]
		public string Twitter { get; set; }

		[JsonProperty("user-invited")]
		public int UserInvited { get; set; }

		[JsonProperty("user-invited-date")]
		public DateTime? UserInvitedDate { get; set; }

		[JsonProperty("user-invited-status")]
		public string UserInvitedStatus { get; set; }

		[JsonProperty("user-name")]
		public string UserName { get; set; }

		[JsonProperty("user-type")]
		public string UserType { get; set; }

		[JsonProperty("userUUID")]
		public int? UserUuId { get; set; }

        public DateTime? HireDate { get; set; }
        public DateTime? BirthDate { get; set; }
        public EnglishLevel? EnglishLevel { get; set; }

        [ForeignKey("DefaultPaymentMethod")]
        public int? DefaultPaymentMethodId { get; set; }

	    public UserPaymentMethod DefaultPaymentMethod { get; set; }

	    public virtual ICollection<UserPaymentMethod> UserPaymentMethods { get; set; }

		public virtual ICollection<UserPayment> UserPayments { get; set; }

		public virtual ICollection<UserRole> UserRoles { get; set; }
        public virtual ICollection<ProjectUserAccount> ProjectUserAccounts { get; set; }
    }
}