# tests/testthat/test-main.R

box::use(
  testthat[test_that, expect_true, expect_false],
  app/view/layout/nav_model[SCOPES, SCOPE_LABELS],
  app/logic/routing_spec
)

test_that("nav model labels cover all scopes", {
  expect_true(setequal(SCOPES, names(SCOPE_LABELS)))
})

test_that("routing spec returns a module per scope", {
  pages <- routing_spec$page_modules_by_scope()
  controls <- routing_spec$control_modules_by_scope()

  for (scope in SCOPES) {
    expect_false(is.null(pages[[scope]]))
    expect_false(is.null(controls[[scope]]))
    expect_true(is.function(pages[[scope]]$ui))
    expect_true(is.function(controls[[scope]]$ui))
  }
})
