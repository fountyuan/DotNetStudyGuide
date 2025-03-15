using Fountain.Web.Wcf;
using System;
using System.ServiceModel;
using System.ServiceModel.Description;

namespace Fountain.Web.Host
{
    internal class Program
    {
        static void Main(string[] args)
        {
            #region 采用代码方式实现对契约的绑定
            Uri baseAddress = new Uri("http://127.0.0.1:8081/");
            using (ServiceHost host = new ServiceHost(typeof(OrderService), baseAddress))
            {
                //使用指定的协定、绑定和终结点地址将服务终结点添加到承载服务中
                host.AddServiceEndpoint(typeof(IOrderService), new WSHttpBinding(), "OrderService");

                #region Behavior
                ServiceMetadataBehavior behavior = new ServiceMetadataBehavior();
                behavior.HttpGetEnabled = true;
                behavior.HttpGetUrl = new Uri("http://127.0.0.1:8081/OrderService/metadata");
                host.Description.Behaviors.Add(behavior);
                #endregion

                host.Opened += delegate
                {
                    Console.WriteLine("服务已经启动，按任意键终止服务！");
                };

                host.Open();
                Console.Read();
            }
            #endregion
        }
    }
}
