using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Fountain.DeepSeekDemo
{
    internal class Program
    {
        static async Task Main(string[] args)
        {
           
            var configuration = new ConfigurationBuilder()
                .SetBasePath(AppContext.BaseDirectory)
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .Build();

            var serviceProvider = new ServiceCollection()
                .AddSingleton<IConfiguration>(configuration)
                .AddSingleton<DeepSeekService>()
                .BuildServiceProvider();

            var deepSeekService = serviceProvider.GetRequiredService<DeepSeekService>();

            var response = await deepSeekService.SendMessageAsync("");
            Console.ForegroundColor = ConsoleColor.DarkGreen;
            Console.Write("DeepSeek: ");
            Console.ResetColor();
            Console.WriteLine(response);
            do
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.Write("给DeepSeek 发信息: ");
                Console.ResetColor();

                var userInput = Console.ReadLine();

                if (userInput?.ToLower() == "exit")
                {
                    Console.WriteLine("再见！很高兴和你互动。");
                    break;
                }

                if (!string.IsNullOrEmpty(userInput))
                {
                    response = await deepSeekService.SendMessageAsync(userInput);
                    Console.ForegroundColor = ConsoleColor.DarkGreen;
                    Console.Write("DeepSeek: ");
                    Console.ResetColor();
                    Console.WriteLine(response);
                }

            } while (true);
        }
    }
}
