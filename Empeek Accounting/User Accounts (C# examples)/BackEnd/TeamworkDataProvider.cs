using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Configuration;
using Empeek.Accounting.Common;
using Empeek.Accounting.Model.Models.Account;
using Empeek.Accounting.Model.Models.Invoice;
using Newtonsoft.Json.Linq;

namespace Empeek.Accounting.Core.Integration.Teamwork
{
    public class TeamworkDataProvider : ITeamworkDataProvider
    {

        private readonly string _serverPath;

        public TeamworkDataProvider()
        {
            _serverPath = "https://" + AppSettings.TeamworkDomainName + ".teamwork.com/";
        }
        public async Task<List<InvoiceHeader>> GetActiveInvoices()
        {
            var invoices = await GetFromTeamwork<List<InvoiceHeader>>("invoices.json", "invoices");

            foreach (var invoice in invoices)
            {
                var detailedInvoice = await GetFromTeamwork<InvoiceHeader>($"invoices/{ invoice.TeamWorkId}.json", "invoice");
                invoice.LineItems = detailedInvoice.LineItems;
            }

            return invoices;
        }

        public async Task<List<UserAccount>> GetUserAccounts()
        {
            var users = await GetFromTeamwork<List<UserAccount>>("people.json", "people");
            return users != null && users.Any() ? users.Where(x => x.CompanyId == AppSettings.TeamworkCompanyId).ToList() : users;
        }

        private async Task<T> GetFromTeamwork<T>(string address, string propertyName) where T : new()
        {
            using (var client = GetHttpClient())
            {
                var response = await client.GetAsync(address);

                if (!response.IsSuccessStatusCode) return new T();

                var result = response.Content.ReadAsStringAsync().Result;

                var invoicesObject = JToken.Parse(result);

                var invoiceArray =
                    invoicesObject.Children<JProperty>().FirstOrDefault(x => x.Name == propertyName).Value;

                var invoices = invoiceArray.ToObject<T>();
                return (T)Convert.ChangeType(invoices, typeof(T));
            }
        }

        private HttpClient GetHttpClient()
        {
            var client = new HttpClient { BaseAddress = new Uri(_serverPath) };
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", Convert.ToBase64String(System.Text.Encoding.ASCII.GetBytes($"{AppSettings.TeamworkApiKey}:x")));
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            return client;
        }
    }
}