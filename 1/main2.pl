sub numberOfOccurences {
	my ($arr, $val) = @_;
	my $count = 0;
	foreach my $elem (@$arr) {
		if ($elem == $val) {
			$count++;
		}
	}
	return $count;
}

open(fh, "input.txt") or die "File '$filename' can't be opened"; 

my @arr1 = ();
my @arr2 = ();

while (<fh>) {
	my ($val1, $val2) = split(/   /, $_);
	push @arr1, $val1;
	push @arr2, $val2;
}

my @similarity_scores = ();
for (my $i = 0; $i < scalar(@arr1); $i++) {
	my $similarity_score = $arr1[$i] * numberOfOccurences(\@arr2, $arr1[$i]);
	push(@similarity_scores, $similarity_score);
}

my $sum = 0;
map { $sum += $_ } @similarity_scores;

print "Total similarity score: " . $sum . "\n";
