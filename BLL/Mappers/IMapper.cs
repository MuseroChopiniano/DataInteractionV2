using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Entities;

namespace BLL.Mappers
{
    public interface IMapper<T>
    {
        T Read(T entity);
        List<T> ReadAll();
        int Upsert(T entity);
        int Delete(T entity);

        List<SqlParameter> GenerateParameters(T entity);

        List<T> MapEntityFromTable(DataTable table);
    }
}
