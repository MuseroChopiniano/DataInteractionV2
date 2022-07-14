using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Entities;
using BLL.Mappers;

namespace BLL
{
    public class SegmentManager
    {

        public List<Segment> GetSegments()
        {
            SegmentMapper mapper = new SegmentMapper();
            return mapper.ReadAll();
        }

        public void UpsertSegment(Segment segment)
        {
            bool update = segment.Id != 0;
            int result = 0;

            SegmentMapper mapper = new SegmentMapper();
            result = mapper.Upsert(segment);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = update ? EventType.ObjectUpdate : EventType.ObjectInsert,
                    Entity = "Segment",
                    Message = "The Segment with Id " + segment.Id + " has been upserted by User with Id " + segment.LastModifiedById,
                    LastModifiedById = segment.LastModifiedById,
                    CreatedById = segment.LastModifiedById
                });
            }

        }

        internal List<Customer> GetCustomers(Segment segment)
        {
            CustomerMapper mapper = new CustomerMapper();
            return mapper.ReadFromSegment(segment);
        }

        public void DeleteSegment(Segment segment)
        {
            int result = 0;
            SegmentMapper mapper = new SegmentMapper();
            result = mapper.Delete(segment);
            if (result != -2)
            {
                LogManager logManager = new LogManager();
                logManager.SaveLog(new LogEntity()
                {
                    EventType = EventType.ObjectDelete,
                    Entity = "Segment",
                    Message = "The Segment with Id " + segment.Id + " has been deleted by " + segment.LastModifiedById,
                    LastModifiedById = segment.LastModifiedById,
                    CreatedById = segment.LastModifiedById

                });
            }
        }
    }
}
