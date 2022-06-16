using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Entities;
using BLL.Mappers;



namespace BLL
{
    public class LogManager
    {
        public List<LogEntity> GetLogs()
        {
            LogMapper mapper = new LogMapper();
            return mapper.ReadAll();
        }

        public void SaveLog(LogEntity log)
        {
            LogMapper mapper = new LogMapper();
            mapper.Upsert(log);
        }
    }


}
