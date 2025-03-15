using System;
using System.Runtime.Serialization;
using System.ServiceModel;

namespace Fountain.Web.Wcf
{
    [ServiceContract]
    public interface IOrderService
    {
        [OperationContract]
        OrderEntity GetOrderByNo(string orderNo);
    }
    
    [DataContract]
    public class OrderEntity
    {
        [DataMember]
        public string OrderNo {get;set;}

        [DataMember]
        public string CustomerCode{ get; set; }

        [DataMember]
        public DateTime OrderDate { get; set; }
        [DataMember]
        public decimal Amount { get; set; }
    }
}
