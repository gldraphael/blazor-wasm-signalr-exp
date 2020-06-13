namespace Shared.Messages.OrderMessages
{
    public class PlaceOrder
    {

    }

    public enum OrderStatus
    {
        New,
        InReview,
        Processing,
        Fulfilled
    }

    public class OrderPlaced
    {
        public string OrderId { get; }
        public OrderStatus Status { get; } = OrderStatus.New;

        public OrderPlaced(string orderId)
        {
            OrderId = orderId;
        }
    }

    public class OrderStatusChanged
    {
        public string OrderId { get; }
        public OrderStatus Status { get; }

        public OrderStatusChanged(string orderId, OrderStatus status)
        {
            OrderId = orderId;
            Status = status;
        }
    }
}
