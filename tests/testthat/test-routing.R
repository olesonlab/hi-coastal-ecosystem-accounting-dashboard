# tests/testthat/test-routing.R

box::use(
  testthat[test_that, expect_true, expect_named, expect_length],
  app/view/layout/nav_model[SCOPES],
  app/logic/routing_spec
)

test_that("routing spec covers all navigation scopes", {
  pages <- routing_spec$page_modules_by_scope()
  controls <- routing_spec$control_modules_by_scope()

  # Named lists
  expect_named(pages, SCOPES)
  expect_named(controls, SCOPES)

  # No missing scopes
  expect_true(all(SCOPES %in% names(pages)))
  expect_true(all(SCOPES %in% names(controls)))

  # Sanity: same number of entries as scopes
  expect_length(pages, length(SCOPES))
  expect_length(controls, length(SCOPES))
})
