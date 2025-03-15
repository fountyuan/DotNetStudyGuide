using Fountain.Web.Wcf;
using System;
using System.ServiceModel;

namespace Fountain.Web.Demo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            using (ChannelFactory<IOrderService> channelFactory = new ChannelFactory<IOrderService>(new WSHttpBinding(), "http://127.0.0.1:8081/OrderService"))
            {
                IOrderService proxy = channelFactory.CreateChannel();
                using (proxy as IDisposable)
                {
                    Console.WriteLine(proxy.GetOrderByNo("SO25031500001").Amount.ToString());
                    Console.ReadLine();
                }
            }
        }
    }
}
