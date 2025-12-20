# app/view/__init__.R
box::use(
  app/view/layout/dashboard_shell,
  app/view/layout/nav_model,
  app/view/layout/nav,
  app/view/accounts/extents/extents_page,
  app/view/accounts/conditions/conditions_page,
  app/view/accounts/uses/fisheries_valuation/fisheries_valuation_page,
  app/view/accounts/uses/recreation/recreation_page,
  app/view/controls/controls_conditions,
  app/view/controls/controls_extents,
  app/view/controls/controls_global,
  app/view/controls/controls_uses_fisheries_valuation,
  app/view/controls/controls_uses_recreation
)