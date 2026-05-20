using {purchaserequest as my} from '../db/schema.cds';
using {API_BUSINESS_PARTNER} from './external/API_BUSINESS_PARTNER';

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

   // entity Suppliers        as projection on my.Supplier;
   entity Suppliers        as
      projection on API_BUSINESS_PARTNER.A_BusinessPartner {
         BusinessPartner         as ID,
         BusinessPartnerName     as name,
         BusinessPartnerCategory as category,
         LastName                as lastName,
         FirstName               as firstName,
         CreationDate            as createdOn,
         virtual isPriority : Boolean
      };

   entity CostCenters      as projection on my.CostCenter;
}
