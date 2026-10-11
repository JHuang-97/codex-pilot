PilotKit is a minimal, dependency-free Swift package for Karvonen heart-rate zones, exponentially weighted moving averages, and acute-to-chronic workload ratios. It is a Muse x Codex pipeline pilot.

The iOS project is generated from `project.yml` with XcodeGen. Regenerate it
after changing targets, build settings, or dependencies:

```sh
xcodegen generate
```

## Xcode Cloud

The shared `PilotKit` scheme archives the iOS app for TestFlight. Xcode Cloud
runs the Swift package tests from `ci_scripts/ci_post_clone.sh` before building.

Configure the distribution workflow with:

- a branch-change start condition for `main`;
- an iOS Archive action using the `PilotKit` scheme;
- deployment preparation set to TestFlight and App Store;
- an internal TestFlight distribution post-action.
