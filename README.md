## OpenTelemetry Demo

This repository contains a copy of the OpenTelemetry Demo application, which should be used as a study object to test some Trace-based testing tools.

The original repo can be found on: https://github.com/open-telemetry/opentelemetry-demo.

The objectives of this repository are:

- Test the capabilities of the tools with the system working correctly.
- Create some intentional errors in various services and validate the tools' ability to help find the root of the error.
- Create some performance problems in applications and validate the tools' ability to create tests measuring the duration of spans.

OpenTelemetry Demo was chosen due to its complexity and well-implemented observability using the OpenTelemetry protocol, which is widely adopted in the market and used by all current Trace-Based testing tools.

This project is not a fork of the original repository because there is no reason to keep updating it with new commits in the community repository, furthermore, as it is intended to be used only for my specific TCC scenario, there will be no valuable commits for sync with the original repository.

The main branch will contain the original code of the [v1.5.0](https://github.com/open-telemetry/opentelemetry-demo/tree/1.5.0) tag on the original repository, while the other branches will contain some changes on the services to simulate errors scenarios.

During the TCC research phase, the community adopted [Tracetest](https://tracetest.io) as a tool to test the OpenTelemetry Demo application. I will try to use these tests as a guide to compare this tool with others.
