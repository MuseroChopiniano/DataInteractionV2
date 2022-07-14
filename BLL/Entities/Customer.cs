using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class Customer : SystemEntity
    {
		

		private string name;

		public string Name
		{
			get { return name; }
			set { name = value; }
		}

		

		public int Age
		{
			get {
				if (this.DateOfBirth != null)
				{
					var age = DateTime.Today.Year - this.DateOfBirth.Value.Year;
					if (this.DateOfBirth.Value.Date > DateTime.Today.AddYears(-age))
					{
						age--;
					};
					return age;
				}
				else return 0;
			}
		}

		public DateTime? DateOfBirth { get; set; }

		public string ExternalId { get; set; }

	

		private string email;

		public string Email
		{
			get { return email; }
			set { email = value; }
		}

	}
}
