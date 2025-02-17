namespace Fountain.DeepSeekDemo.Models
{
    public class DeepSeekChoice
    {
        public DeepSeekMessage Message { get; set; }
        public int Index { get; set; }
        public string FinishReason { get; set; } = "";
    }
}
