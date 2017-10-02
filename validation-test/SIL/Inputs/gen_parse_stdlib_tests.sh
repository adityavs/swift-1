#!/usr/bin/env bash

process_count=17
process_id_max=$((process_count - 1))

for id in $(seq 0 $process_id_max); do

  cat > parse_stdlib_$id.sil <<__EOF__
//// Automatically Generated From validation-test/SIL/Inputs/gen_parse_stdlib_tests.sh
////// Do Not Edit Directly!

// Make sure that we can parse the stdlib.sil deserialized from Swift.swiftmodule.

// RUN: rm -f %t.*
// FIXME: reenable -enable-sil-verify-all in the following two RUN lines.
//        See <rdar://problem/24060338> Identify problems with textual SIL and fix them
// RUN: %target-sil-opt -assume-parsing-unqualified-ownership-sil -enable-sil-verify-all=false -sil-disable-ast-dump %platform-module-dir/Swift.swiftmodule -module-name=Swift -o %t.sil
// RUN: %target-sil-opt -assume-parsing-unqualified-ownership-sil -enable-sil-verify-all=false %t.sil -ast-verifier-process-count=$process_count -ast-verifier-process-id=$id > /dev/null
// REQUIRES: long_test
// REQUIRES: nonexecutable_test

// FIXME: Re-enable on Linux when we're no long running out of memory.
// REQUIRES: OS=macosx
__EOF__

done
