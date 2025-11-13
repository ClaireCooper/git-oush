#!/usr/bin/env bats

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$DIR/../src:$DIR:$PATH"
}

@test "git oush plays sound" {
    run git oush
    assert_output -p '.wav'
    assert_success
}

@test "git oush stores oush flag" {
    assert [ ! -e /tmp/oush-flag ]
    run git oush
    assert [ -e /tmp/oush-flag ]
}

teardown() {
    rm -f /tmp/oush-flag
}