using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class Access
    {
        private SqlConnection connection;
        private SqlTransaction transaction;
        public void OpenConnection()
        {
            if (this.connection == null || this.connection.State != ConnectionState.Open)
            {

                this.connection = new SqlConnection();
                //this.connection.ConnectionString = "Data Source=BIGNOTE\\SQLEXPRESS01;Initial Catalog=DataInteraction;Integrated Security=True";
                this.connection.ConnectionString = ConfigurationManager.ConnectionStrings["DataInteractionDB"].ConnectionString;
                this.connection.Open();
            }
        }
        public void InitiateTransaction()
        {
            this.OpenConnection();
            this.transaction = connection.BeginTransaction();
        }
        public void CommitTransaction()
        {
            this.transaction.Commit();
            this.transaction = null;
            this.CloseConnection();
        }
        public void RollbackTransaction()
        {
            this.transaction.Rollback();
            this.transaction = null;
            this.CloseConnection();
        }

        public void CloseConnection()
        {
            this.connection.Close();
            this.connection.Dispose();
            connection = null;
        }

        private SqlCommand BuildCommand(string commandName, List<SqlParameter> parameters)
        {
            SqlCommand aCommand = new SqlCommand();
            if (this.transaction != null)
            {
                aCommand.Transaction = this.transaction;
            }
            aCommand.CommandText = commandName;
            aCommand.CommandType = CommandType.StoredProcedure;
            aCommand.Connection = this.connection;

            if (parameters != null && parameters.Count > 0)
            {
                aCommand.Parameters.AddRange(parameters.ToArray());
            }

            return aCommand;
        }

        public SqlParameter BuildParameter(string key, string value)
        {
            SqlParameter parameter = new SqlParameter(key, value);
            parameter.DbType = DbType.String;
            return parameter;
        }
        public SqlParameter BuildParameter(string key, decimal value)
        {
            SqlParameter parameter = new SqlParameter(key, value);
            parameter.DbType = DbType.Decimal;
            return parameter;
        }
        public SqlParameter BuildParameter(string key, int value)
        {
            SqlParameter parameter = new SqlParameter(key, value);
            parameter.DbType = DbType.Int32;
            return parameter;
        }
        public SqlParameter BuildParameter(string key, DateTime value)
        {
            SqlParameter parameter = new SqlParameter(key, value);
            parameter.DbType = DbType.DateTime;
            return parameter;
        }
        public int Save(string procedure, List<SqlParameter> parameters)
        {
            int rows = 0;
            this.OpenConnection();
            SqlCommand comando = BuildCommand(procedure, parameters);
            try
            {
                rows = comando.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                rows = -1;
            }
            if (this.transaction == null)
            {
                this.CloseConnection();
            }

            return rows;
        }
        public int Save(string procedure, List<SqlParameter> parameters, Boolean scalar)
        {
            if (!scalar)
            {
                return this.Save(procedure, parameters);
            }
            int result = 0;
            this.OpenConnection();
            SqlCommand comando = BuildCommand(procedure, parameters);
            try
            {
                result = int.Parse(comando.ExecuteScalar().ToString());
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                result = -1;
            }
            if (this.transaction == null)
            {
                this.CloseConnection();
            }

            return result;
        }
        public DataTable Read(string procedure, List<SqlParameter> parametes)
        {

            DataTable table = new DataTable();
            this.OpenConnection();
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = BuildCommand(procedure, parametes);
            adapter.Fill(table);
            this.CloseConnection();
            return table;
        }
    }
}
