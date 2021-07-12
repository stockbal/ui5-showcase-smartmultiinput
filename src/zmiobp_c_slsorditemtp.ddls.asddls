@AbapCatalog.sqlViewName: 'ZMIOBPCSOITP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item (TX)'

@Search.searchable: true

@Metadata.allowExtensions: true

@ObjectModel: {
   semanticKey: ['SalesOrderItem'],
   createEnabled: true,
   deleteEnabled: true,
   updateEnabled: true
}
define view ZMIOBP_C_SlsOrdItemTP
  as select from ZMIOBP_I_SlsOrdItemTP
  
  /* Compositional associations    */
  association [1..1] to ZMIOBP_C_SalesOrderTP          as _SalesOrder          on $projection.SalesOrderUUID = _SalesOrder.SalesOrderUUID
  association [0..*] to ZMIOBP_C_SlsOrdItmCurrAssgmtTP as _SalesOrdItmCurrency on $projection.SalesOrderItemUUID = _SalesOrdItmCurrency.SalesOrderItemUUID
{
  key SalesOrderItemUUID,
      SalesOrderUUID,
      
      @Search.defaultSearchElement: true
      SalesOrderItem,
      Product,
      CurrencyCode,
      GrossAmount,
      Quantity,
      
      /* Compositional Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _SalesOrder,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _SalesOrdItmCurrency,
      /* Associations */
      _Currency,
      _Product
}
