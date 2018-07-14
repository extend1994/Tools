ep=0
for para in $@; do
  ep=$(($ep+1))
  curl -X GET -H "Authorization: Bearer jMvOMEJIw3Z9KDJ92TselLS5bG3W" \
              -H "Content-Type: application/json" \
              -H "Accept: application/json" "$para" | jq .l | xargs curl -o 10-$ep.f4v
done
