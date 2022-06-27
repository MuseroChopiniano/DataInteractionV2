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
            SegmentMapper mapper = new SegmentMapper();
            mapper.Upsert(segment);
        }

        public void DeleteSegment(Segment segment)
        {
            SegmentMapper mapper = new SegmentMapper();
            mapper.Delete(segment);
        }
    }
}
