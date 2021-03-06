# Report build configuration
report_configuration("
  ==================================== >DASHBOARD_
  UNIX
  UNIX_DISTRIBUTION
  UNIX_DISTRIBUTION_VERSION
  APPLE
  ====================================
  CMAKE_VERSION
  ====================================
  CTEST_BUILD_NAME(DASHBOARD_BUILD_NAME)
  CTEST_CHANGE_ID
  CTEST_BUILD_FLAGS
  CTEST_CMAKE_GENERATOR
  CTEST_CONFIGURATION_TYPE
  CTEST_CONFIGURE_COMMAND
  CTEST_GIT_COMMAND
  CTEST_SITE
  CTEST_UPDATE_COMMAND
  CTEST_UPDATE_VERSION_ONLY
  ====================================
  ")

# Execute download step
execute_step(cpplint download)

# Execute lint step (or skip, if download failed)
if(DASHBOARD_SUPERBUILD_FAILURE)
  notice("CTest Status: NOT CONTINUING BECAUSE SUPERBUILD WAS NOT SUCCESSFUL")
else()
  execute_step(cpplint lint)
endif()

# Determine build result and report dashboard status
if(NOT DASHBOARD_FAILURE)
  format_plural(DASHBOARD_MESSAGE
    ZERO "SUCCESS"
    ONE "SUCCESS BUT WITH 1 BUILD WARNING"
    MANY "SUCCESS BUT WITH # BUILD WARNINGS"
    ${DASHBOARD_NUMBER_BUILD_WARNINGS})
endif()

execute_step(common report-status)
