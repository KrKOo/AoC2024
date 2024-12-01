open(fh, "input.txt") or die "File '$filename' can't be opened"; 

my @arr1 = ();
my @arr2 = ();

while (<fh>) {
	my ($val1, $val2) = split(/   /, $_);
	push @arr1, $val1;
	push @arr2, $val2;
}

my @sortedArr1 = sort @arr1;
my @sortedArr2 = sort @arr2;

my @diffs = ();
for (my $i = 0; $i < scalar(@sortedArr1); $i++) {
	my $diff = $sortedArr1[$i] - $sortedArr2[$i];
	push(@diffs, abs($diff));
}

my $sum = 0;
map { $sum += $_ } @diffs;

print "Sum of differences: " . $sum . "\n";
