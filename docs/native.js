$(document).ready(function () {
  const anyDuplicates = (a) => {
    if (a.length === 0) return false;
    const tail = a.slice(1);
    if (tail.includes(a[0])) {
      return true;
    } else {
      return anyDuplicates(tail);
    }
  };

  const passphraseCheck = (passphrase) => {
    const words = passphrase.split(" ");
    if (words.length <= 1) return false;
    return (!anyDuplicates(words));
  };

  const validPassphrases = (xs) => {
    if (xs.length === 0) return 0;
    const tail = xs.slice(1);
    if (passphraseCheck(xs[0])) {
      return 1 + validPassphrases(tail);
    } else {
      return validPassphrases(tail);
    }
  };
  
  $("#part1js").click(function() {
    const input = $("#input").val();
    const lines = input.split("\n");
    const result = validPassphrases(lines);
    $("#output").html(result);
  });
});
