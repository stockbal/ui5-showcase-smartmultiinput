@AbapCatalog.sqlViewName: 'ZMIOBPCSOICATP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item Currency (TX)'

@Search.searchable: true

@Metadata.allowExtensions: true

@ObjectModel: {
   semanticKey: ['CurrencyCode'],
   createEnabled: true,
   deleteEnabled: true,
   updateEnabled: true
}

define view ZMIOBP_C_SlsOrdItmCurrAssgmtTP
  as select from ZMIOBP_I_SlsOrdItmCurrAssgmtTP

  /* Compositional associations    */
  association [1..1] to ZMIOBP_C_SalesOrderTP as _SalesOrder     on $projection.SalesOrderUUID = _SalesOrder.SalesOrderUUID
  association [1..1] to ZMIOBP_C_SlsOrdItemTP as _SalesOrderItem on $projection.SalesOrderItemUUID = _SalesOrderItem.SalesOrderItemUUID
{
  key SalesOrderItemCurrencyUUID,
      SalesOrderUUID,
      SalesOrderItemUUID,

      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'SEPM_I_Currency', element: 'Currency' }}]
      CurrencyCode,

      /* Compositional associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_ROOT]
      _SalesOrder,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT]
      _SalesOrderItem,
      /* Associations */
      _Currency
}
