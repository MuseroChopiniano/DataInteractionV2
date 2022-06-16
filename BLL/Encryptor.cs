using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class Encryptor
    {
        private byte[] GetHash(string texto)
        {
            using (HashAlgorithm algorimo = SHA256.Create())
                return algorimo.ComputeHash(Encoding.UTF8.GetBytes(texto));
        }
        public string GenerateHash(string texto)
        {
            StringBuilder generador = new StringBuilder();
            foreach (byte b in this.GetHash(texto))
            {
                generador.Append(b.ToString("X2"));
            }
            return generador.ToString();
        }
    }
}
