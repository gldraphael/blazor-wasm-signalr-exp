namespace Messages.OrderMessages
{
    public class PlaceOrder
    {

    }

    public enum OrderState
    {
        New,
        InReview,
        Processing,
        Fulfilled
    }

    public class OrderPlaced
    {
        public string OrderId { get; }
        public OrderState State { get; } = OrderState.New;

        public OrderPlaced(string orderId)
        {
            OrderId = orderId;
        }
    }

    public class OrderStatusChanged
    {
        public string OrderId { get; }
        public OrderState State { get; }

        public OrderStatusChanged(string orderId, OrderState state)
        {
            OrderId = orderId;
            State = state;
        }
    }
}
