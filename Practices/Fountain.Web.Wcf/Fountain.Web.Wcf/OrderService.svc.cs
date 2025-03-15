using System;
using System.ServiceModel;

namespace Fountain.Web.Wcf
{
   [ServiceBehavior(ConcurrencyMode = ConcurrencyMode.Multiple, InstanceContextMode = InstanceContextMode.PerCall)]
    public class OrderService : IOrderService
    {
        public OrderEntity GetOrderByNo(string orderNo)
        {
            OrderEntity orderEntity = new OrderEntity();
            orderEntity.OrderNo = "SO25031500001";
            orderEntity.OrderDate = DateTime.Now;
            orderEntity.CustomerCode = "JT";
            orderEntity.Amount = 5000.00M;
            return orderEntity;
        }
    }
}
