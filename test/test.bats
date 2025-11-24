#!/usr/bin/env bats

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$DIR/../bin:$DIR:$PATH"
}

@test "git oush plays sound" {
    run git oush
    assert_output -p '.wav 0.0'
    assert_success
}

@test "git oush -f plays loud sound" {
    run git oush -f
    assert_output -p '.wav +20.0'
    assert_success
}

@test "git oush --force plays loud sound" {
    run git oush --force
    assert_output -p '.wav +20.0'
    assert_success
}