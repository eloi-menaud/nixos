



windows=$(i3-msg -t get_tree | jq -r '
  [ .. | objects
    | select(has("window") and .window != null)
    | {
        class: .window_properties.class,
        title: .name,
        window_type: .window_type,
        focused: .focused,
        window: .window,
        id: .id,
        transient_for: .window_properties.transient_for
      }
  ]
  | sort_by(.class, (if .window_type == "normal" then 0 else 1 end))
')


if test "$1" = "prev"
then
	to_focus=$(echo "$windows" | jq '
	  (map(.focused) | index(true)) as $i
	  | . as $all
	  | ($all + $all) as $dup
	  | (
	      ($dup[0:$i] | reverse | map(select(.window_type == "normal")) | first)
	    )
	    // .[$i]
	')
else
	to_focus=$(echo "$windows" | jq '
	  (map(.focused) | index(true)) as $i
	  | . as $all
	  | ($all + $all) as $dup
	  | ($dup[($i+1):($i+length)] | map(select(.window_type == "normal")) | first) // .[$i]
	')
fi

transient=$( echo "$windows" | jq --argjson id $(echo $to_focus | jq -r ".window") 'map(select(.transient_for == $id))')

echo "to focus : $to_focus"
echo "with : $transient"

i3-msg "[con_id=$(echo $to_focus | jq -r '.id')] focus"


echo "$transient" | jq -r '.[].id' | while read -r id
do
  i3-msg "[con_id=$id] focus"
done



