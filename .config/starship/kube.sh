#!/bin/sh
# Usage: kube.sh ocp|k8s
# Prints the active cluster name and exits 0 only if the current kubeconfig
# context has credentials (so it hides after `oc logout`, which leaves the
# context but empties its user entry to `user: {}`) and its kind matches.
# OCP contexts look like "<ns>/api-<cluster>:6443/<user>".
# Reads only the first file of $KUBECONFIG (or ~/.kube/config); pure awk, ~ms.
kind=$1
cfg=${KUBECONFIG:-$HOME/.kube/config}
cfg=${cfg%%:*}
[ -r "$cfg" ] || exit 1

ctx=$(awk '
  /^[A-Za-z]/ { sect = $1; sub(/:$/, "", sect) }
  /^current-context:/ { cur = $2 }
  sect == "contexts" && /^    user:/ { pu = $2 }
  sect == "contexts" && /^  name:/ { cu[$2] = pu; pu = "" }
  sect == "users" && /^- name:/ { u = $3 }
  sect == "users" && /^  user:/ { if ($2 != "{}") ok[u] = 1 }
  END { if (cur != "" && ok[cu[cur]]) print cur }
' "$cfg")
[ -n "$ctx" ] || exit 1

case $ctx in
  */api-*:*/*)
    [ "$kind" = ocp ] || exit 1
    name=${ctx#*/api-}
    printf '%s\n' "${name%%:*}" ;;
  *)
    [ "$kind" = k8s ] || exit 1
    printf '%s\n' "$ctx" ;;
esac
