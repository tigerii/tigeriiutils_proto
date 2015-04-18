#!/usr/bin/awk -f

    { gsub(/[,:;!?(){}]/, "")
      for(i = 1; i <= NF; i++)
        count[$i]++
    }
END { for (w in count)
        print count[w], w | "sort -rn"
    }
