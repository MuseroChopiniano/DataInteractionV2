using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class User : SystemEntity
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string Status { get; set; }
        public int BlockCounter { get; set; }

        public void IncreaseBlockCounter()
        {
            this.BlockCounter++;
            if(this.BlockCounter >= 3)
            {
                this.Status = "Blocked";
            }
        }
        public bool IsBlocked() {
            return this.Status == "Blocked";
        }

    }
}
