using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Fountain.DeepSeekDemo
{
    public static class ConsoleExtension
    {
        public static void PrintBotResponse(string response)
        {
            Console.ForegroundColor = ConsoleColor.DarkGreen;
            Console.Write("DeepSeek: ");
            Console.ResetColor();
            Console.WriteLine(response);
        }
    }
}
