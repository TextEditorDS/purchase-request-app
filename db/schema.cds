namespace purchaserequest;

using { cuid, managed } from '@sap/cds/common';

entity PurchaseRequest : cuid, managed {
    description : String(80);
    amount : Decimal(15,2);
    status : String(20) default 'DRAFT';
    priority    : String(10) default 'NORMAL';
    supplier   : Association to Supplier;
    costCenter : Association to CostCenter;
}

entity Supplier : cuid {
   name             : String(60);
   email            : String(80);
   purchaseRequests : Association to many PurchaseRequest
                      on purchaseRequests.supplier = $self;
}
 
entity CostCenter {
   key code : String(10);
   name    : String(80);
}