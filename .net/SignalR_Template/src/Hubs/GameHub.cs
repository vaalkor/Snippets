using Microsoft.AspNetCore.SignalR;
using System;
using System.Threading.Tasks;

namespace ChatSample.Hubs
{
    public class GameHub : Hub
    {
        private IHubContext<GameHub> _hubContext;

        public GameHub(IHubContext<GameHub> hubContext)
        {
            _hubContext = hubContext;
        }

        public async override Task OnConnectedAsync()
        {
            await base.OnConnectedAsync();
        }

        public async override Task OnDisconnectedAsync(Exception exception)
        {
            await base.OnDisconnectedAsync(exception);
        }

        public async Task ServerMessage(string message)
        {
            await Clients.All.SendAsync("clientMessage", $"I recieved your message: '{message}'. Thanks very much Mr ClientId: {Context.ConnectionId}!");
        }

    }
}