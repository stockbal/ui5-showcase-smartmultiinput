@AbapCatalog.sqlViewName: 'ZMIOBPISOICATP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item Currency (TX)'

@Search.searchable:       true

@ObjectModel: {
  semanticKey:  [ 'CurrencyCode' ],
  writeActivePersistence: 'zmiobp_sordic',
  createEnabled: true,
  deleteEnabled: true,
  updateEnabled: true,
  writeDraftPersistence: 'zmiobp_sordicd'
}


define view ZMIOBP_I_SlsOrdItmCurrAssgmtTP
  as select from zmiobp_sordic

  /* Compositional associations    */
  association [1..1] to ZMIOBP_I_SalesOrderTP as _SalesOrder     on  $projection.SalesOrderUUID = _SalesOrder.SalesOrderUUID
  association [1..1] to ZMIOBP_I_SlsOrdItemTP as _SalesOrderItem on  $projection.SalesOrderItemUUID = _SalesOrderItem.SalesOrderItemUUID

  /* Associations for value help   */
  association [0..1] to SEPM_I_Currency       as _Currency       on  $projection.CurrencyCode = _Currency.Currency
{
  key salesorderitemcurrencyuuid as SalesOrderItemCurrencyUUID,
      salesorderuuid             as SalesOrderUUID,
      salesorderitemuuid         as SalesOrderItemUUID,

      @Search.defaultSearchElement: true
      @ObjectModel.foreignKey.association: '_Currency'
      @Semantics.currencyCode: true
      currencycode               as CurrencyCode,

      @ObjectModel.association.type: [#TO_COMPOSITION_ROOT]
      _SalesOrder,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT]
      _SalesOrderItem,
      _Currency
}
