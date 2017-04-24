import gzip
import sys

def ParseFields(line):
    fields = {}
    var = line.rstrip("\n").lstrip("#").lstrip(">").split("\t")
    for x in range(0, len(var)):
        fields[var[x]] = x
    return fields

def StripLeadLag(line):
    var = line.rstrip("\n").lstrip("#").lstrip(">").split("\t")
    return var

#Checks if the file is compressed or not and opens it appropriately
def CarefulOpen(samples):
    for sample in samples:
        if sample.endswith("gz"):
            sample_file = gzip.open(sample)
        else:
            sample_file = open(sample)
        yield sample_file

#Read the folders and individual sample names
folders = []
samples = []
infile = open(sys.argv[1])
sys.stderr.write("Samples file name: " + sys.argv[1] + "\n")

for line in infile:
    samples.append(line.rstrip("\n").split("\t")[0])


segment_boundaries = {}
header_printed = False

for sample in CarefulOpen(samples):
    for line in sample:
        var = StripLeadLag(line)
        if line.startswith("#"):
            fields = ParseFields(line)
            if not header_printed:
                print ">chromosome\tbegin\tend"
                header_printed = True
        elif not line.startswith("#") and line!="\n":
            if var[fields["chrom"]] not in segment_boundaries:
                segment_boundaries[var[fields["chrom"]]] = set()
            segment_boundaries[var[fields["chrom"]]].add(var[fields["start"]])
            segment_boundaries[var[fields["chrom"]]].add(var[fields["end"]])
sys.stderr.write("%s\n" % ",".join(sorted(segment_boundaries.keys())))



for chromos in sorted(segment_boundaries):
    sorted_set = sorted(list(segment_boundaries[chromos]), key=int)
    sys.stderr.write("Number of elements in %s = %d\n" % (chromos, len(sorted_set)))
    for x in range(len(sorted_set)-1):
        print "\t".join([chromos, sorted_set[x], sorted_set[x+1]])

