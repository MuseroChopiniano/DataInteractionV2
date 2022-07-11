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

        public string FirstName { get; set; }
        public string LastName { get; set; }

        public string Password { get; set; }
        public string Email { get; set; }
        public UserStatus Status { get; set; }
        public int BlockCounter { get; set; }


        private List<Permission> permissions;

        public List<Permission> Permissions
        {
            get
            {
                if (this.permissions == null)
                {
                    UserManager manager = new UserManager();
                    this.permissions = manager.GetUserPermissions(this);
                    return this.permissions;
                }
                else
                {
                    return this.permissions;
                }
            }
            set
            {
                this.permissions = value;
            }
        }

        public void IncreaseBlockCounter()
        {
            this.BlockCounter++;
            if(this.BlockCounter >= 3)
            {
                this.Status = UserStatus.Blocked;
            }
        }
        public bool IsBlocked() {
            return this.Status == UserStatus.Blocked ;
        }

    }
    public enum UserStatus
    {
        Active,
        Blocked

    }
}
