namespace Fountain.DeepSeekDemo.Models
{
    public class DeepSeekRequest
    {
        public string Model { get; set; } = "deepseek-chat";
        public List<DeepSeekMessage> Messages { get; set; }
        public bool Stream { get; set; } = false;
    }
}
