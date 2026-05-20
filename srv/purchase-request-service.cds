using {purchaserequest as my} from '../db/schema.cds';

// El endpoint final va a ser /odata/v4/purchase-request/...

service PurchaseRequestService @(path: 'purchase-request') {
   entity PurchaseRequests as
      projection on my.PurchaseRequest {
         *,
         amount,
         (
            amount * 1.21
         ) as totalWithTax : Decimal(15, 2)
      };
   entity Suppliers        as projection on my.Supplier;
   entity CostCenters      as projection on my.CostCenter;
}
