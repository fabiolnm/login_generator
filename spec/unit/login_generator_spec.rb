describe LoginGenerator do
  subject { Subject.new }

  describe "email in blank" do
    it "generates nil" do
      assert_nil subject.generate
    end
  end

  describe "invalid email - without @" do
    it "generates with john prefix" do
      subject.email = "john"
      assert_match /^john\d*$/, subject.generate
    end
  end

  describe "too short email" do
    it "generates with jo prefix" do
      subject.email = "jo"
      assert_match /^jo\d*$/, subject.generate
    end
  end

  describe "regular email" do
    before do
      subject.email = "johnlennon@beatles.com"
    end

    describe "6 initials logins available" do
      it "generates with 6 initials and 3 digits" do
        assert_match /^johnle\d{3}$/, subject.generate
      end

      it "generates with 6 initials and 4 digits" do
        subject.use_logins "johnle", 100..999
        assert_match /^johnle\d{4}$/, subject.generate
      end

      it "generates with 6 initials and 5 digits" do
        subject.use_logins "johnle", 100..9999
        assert_match /^johnle\d{5}$/, subject.generate
      end
    end

    describe "5 initials logins available" do
      before do
        subject.use_logins "johnle", 100..99999
      end

      it "generates with 5 initials and 3 digits" do
        assert_match /^johnl\d{3}$/, subject.generate
      end

      it "generates with 5 initials and 4 digits" do
        subject.use_logins "johnl", 100..999
        assert_match /^johnl\d{4}$/, subject.generate
      end

      it "generates with 5 initials and 5 digits" do
        subject.use_logins "johnl", 100..9999
        assert_match /^johnl\d{5}$/, subject.generate
      end
    end

    describe "4 initials logins available" do
      before do
        %w{johnle johnl}.each { |prefix|
          subject.use_logins prefix, 100..99999
        }
      end

      it "generates with 4 initials and 3 digits" do
        assert_match /^john\d{3}$/, subject.generate
      end

      it "generates with 4 initials and 4 digits" do
        subject.use_logins "john", 100..999
        assert_match /^john\d{4}$/, subject.generate
      end

      it "generates with 4 initials and 5 digits" do
        subject.use_logins "john", 100..9999
        assert_match /^john\d{5}$/, subject.generate
      end
    end

    describe "7 initials logins fallback" do
      before do
        %w{johnle johnl john}.each { |prefix|
          subject.use_logins prefix, 100..99999
        }
      end

      it "generates with 4 initials and 3 digits" do
        assert_match /^johnlen\d{3}$/, subject.generate
      end

      it "generates with 4 initials and 4 digits" do
        subject.use_logins "johnlen", 100..999
        assert_match /^johnlen\d{4}$/, subject.generate
      end

      it "generates with 4 initials and 5 digits" do
        subject.use_logins "johnlen", 100..9999
        assert_match /^johnlen\d{5}$/, subject.generate
      end

      describe "Benchmark" do
        bench_performance_constant "generate", 0.99 do
          subject.generate
        end
      end
    end

    describe "Benchmark" do
      before do
        subject.use_logins "johnle", 101..999
      end

      bench_performance_linear "generate", 0.99 do |n|
        n.times { subject.logins_in_use << subject.generate }
      end
    end
  end
end
