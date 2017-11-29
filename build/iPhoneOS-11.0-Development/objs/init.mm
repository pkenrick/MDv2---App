#import <Foundation/Foundation.h>

extern "C" {
    void ruby_init(void);
    void ruby_init_loadpath(void);
    void ruby_script(const char *);
    void *rb_vm_top_self(void);
    void rb_define_global_const(const char *, void *);
    void rb_rb2oc_exc_handler(void);
    void ruby_init_device_repl(void);
void MREP_907D1C9B40564185A8DB8A5E16B8869A(void *, void *);
void MREP_DEA03E667AD84FE9A81156602C5CFA66(void *, void *);
void MREP_CCDEC44DE5EC47548B00E9ACA8510C38(void *, void *);
void MREP_CA5809C415974850815CC545F8B50E61(void *, void *);
void MREP_08CA5C29A267405DB39BCD53AE4858FA(void *, void *);
void MREP_F8B65FF86F564988B4B939E33C627F67(void *, void *);
void MREP_572EA27C0FDC4B358C6264488B9D0591(void *, void *);
void MREP_33C46520B22044BFABE396A843175C52(void *, void *);
void MREP_E9404070CB7F4BB084D9499B8C13796E(void *, void *);
void MREP_A06ECB763A164A11B319650C98404D43(void *, void *);
void MREP_AF05B04A286840AE940C115F34AEF55E(void *, void *);
void MREP_86575CCFDB98407D92A4FDEF1DC0A838(void *, void *);
void MREP_7DE7FD7B05144701A7C68D6510CB4A25(void *, void *);
void MREP_173EBF25A55C48E5954A78BD16925E6E(void *, void *);
void MREP_9C766531FAEB4D6E962B0C3F016378E0(void *, void *);
void MREP_73A4CAD1CDAC40D9B9054BF87D416A7E(void *, void *);
void MREP_F8BACA700F2344D486CD4BD300609331(void *, void *);
void MREP_20715E96069C440DA2EC114C6E671955(void *, void *);
void MREP_326C77003FE0498DA71225C465B7CB8B(void *, void *);
void MREP_FD49B0D3FD92455EB16AD711C5C1BA0E(void *, void *);
void MREP_538B68DE04CF443188E8722383381566(void *, void *);
void MREP_AAD684A00BC04B1B9A94A292401DFB21(void *, void *);
void MREP_70717BC94ABB4212A71DD7B79370812F(void *, void *);
void MREP_C1BC00418B854188B25879B54965EBC0(void *, void *);
void MREP_3CC871CF113C43A98608A1BD7FB54644(void *, void *);
void MREP_7DC3925090E44D7F903CD70B91CFAC33(void *, void *);
void MREP_354EF2771DC64CCBA0C3E0FD440D2DE4(void *, void *);
void MREP_345D6756E8884BDA8C6378DB64FEE49F(void *, void *);
void MREP_667D9667EBD14B98B3363B795FF0CBC9(void *, void *);
void MREP_C272CA2F00BA49688EA605FBB357D2C9(void *, void *);
void MREP_331A815EAC69498DA69E4881CD0E152D(void *, void *);
void MREP_F4FA2A62E491488AB11FD58878A0409C(void *, void *);
void MREP_4BD0D6669C044919A728C798ABCDCCCF(void *, void *);
void MREP_25EAB40CF8D349EC8D4371A085C88A01(void *, void *);
void MREP_835D4B6EC35D43B69D9405451998269A(void *, void *);
void MREP_3D444055AC934E298D6EE14067214C61(void *, void *);
void MREP_2EF88B3BE769493CA25F8D87721D7986(void *, void *);
void MREP_D13380517BE049FAAA70DF107E5FA1D7(void *, void *);
void MREP_D282A3FE57514B0A97A18F88457EC04F(void *, void *);
void MREP_A412E80962564B7DB71A0857D110CCD6(void *, void *);
void MREP_C52BFF57F5584EABB9A61FA24FC31BDE(void *, void *);
void MREP_6BB22DC133DE4434BA45E21B948B47FC(void *, void *);
void MREP_E6B7A8F4E8F4412489CEE1C8F892580B(void *, void *);
void MREP_9EB95861E0044D2BA0227F9B32AF3DBD(void *, void *);
void MREP_A70677EB719F4271ACB898CA9AE30798(void *, void *);
void MREP_E21473363BBF4225B26F9E42CC80F2CC(void *, void *);
void MREP_177863A8076B415FA497D3050924C164(void *, void *);
void MREP_92D0B701848F426B8E8514550BFD92FA(void *, void *);
void MREP_0E5D569D635543E79541C07E56EF0F2A(void *, void *);
void MREP_3AD86C36193A4D93B5A39606317DB0CD(void *, void *);
void MREP_1CA5BB13803B48EF878C047E51320382(void *, void *);
void MREP_CE97296699E442B58ADDB9C5E6C010D0(void *, void *);
void MREP_887F496DACAA4A08BB602B80D0E86E49(void *, void *);
void MREP_279F9DCA58AC43F3B14C3F57B32DCB69(void *, void *);
void MREP_262A3B92E76A4C3B85DC4D7B0A64A65C(void *, void *);
void MREP_6C5AF4CA72584460B4BA4310A9A5E2D5(void *, void *);
void MREP_9B974DFDC4C74BB4B97AD8051E523CE7(void *, void *);
void MREP_0841EE22A74E43E8918D705F18DC8DC1(void *, void *);
void MREP_D39BBA79EE4B417AA0A9BFCACD7C3BF0(void *, void *);
void MREP_C073B59BCFB7412C92C0308F2FEF6E32(void *, void *);
void MREP_7802F4CC62AC4302A2225C16641A55E8(void *, void *);
void MREP_0A7D20FF9F174C9387F7F8EEB626565E(void *, void *);
void MREP_5DEA1813F5BF4149B9C58B599DFD02B4(void *, void *);
void MREP_124D46638CEC4ECB84F394377A1D165A(void *, void *);
void MREP_4D4366C04F294F7CBA106E69C57EB42C(void *, void *);
void MREP_18C9064F8DCA4F86AA0E37A2D2BFA90A(void *, void *);
void MREP_FA3CFA9E9AD34227B5386263CD63CD15(void *, void *);
void MREP_13827C88AB7E47CE843BB370A394F07D(void *, void *);
void MREP_905983B8F1C645E294B97BD79FB950C3(void *, void *);
void MREP_4759ED2444C64785B4046BAF23F35EA3(void *, void *);
void MREP_BD11ADC88E55412CA5D02ABC6BF8427A(void *, void *);
void MREP_E470867ECDAC4A59ACCE94BF186E4913(void *, void *);
void MREP_3E9C901467FE4FB3A5AF37BE37AAD48E(void *, void *);
void MREP_3E63B4EC5FFD40EA95E72D1529546A60(void *, void *);
void MREP_2C069B34BF2E431A8E0AFFCC9FADD9F3(void *, void *);
void MREP_265718AB34644AE5A6444DA4054918B5(void *, void *);
void MREP_47C7E41F1696414A936827F2C23CCB74(void *, void *);
void MREP_822029C810F44ADD8EB5BD02F42E376D(void *, void *);
void MREP_BEA7651CD0B541C28365317CA0DBF2E3(void *, void *);
void MREP_7DB963CA85B6487CA42CCB2B9271D93A(void *, void *);
void MREP_FB19DD4397F1438FB69CAFB71E581D85(void *, void *);
void MREP_F664C83956BB485BB6358F03BA6E5178(void *, void *);
void MREP_B209866F8412485289B3207E3E56CBFC(void *, void *);
void MREP_521B3CEDAE61469BA9D751B296355A0E(void *, void *);
void MREP_2418B877C88748FE9C70E8B8CC64A446(void *, void *);
void MREP_906C5054F8E14C9B9FFB9520917C520B(void *, void *);
void MREP_7B92380E780E4158AFC30376F1C710D3(void *, void *);
void MREP_A60A69C8ACE04A15B2B48DC73B35B1E2(void *, void *);
void MREP_6EC6C68C60124E53A19036B55FA51908(void *, void *);
void MREP_6FEF85A0BD9D4A98AF3B101F922846A3(void *, void *);
void MREP_ACE692312A874067B7ED1DBCFF1D0661(void *, void *);
void MREP_76B3F2AB22DC42B4B82858E684BC383A(void *, void *);
void MREP_05929AD2F342482798B943BC22BC1F63(void *, void *);
void MREP_580B58ED176C4FA485DB79539623E491(void *, void *);
void MREP_463CD98B51834A01A02B5AA002FA3AF5(void *, void *);
void MREP_8D7374A457D942F9856B3ADD6E6E4EB9(void *, void *);
void MREP_0C6675C690E34FB687B34A2F9ED8B9AB(void *, void *);
int rm_repl_port = 58663;
}

extern "C"
void
RubyMotionInit(int argc, char **argv)
{
    static bool initialized = false;
    if (!initialized) {
	ruby_init();
	ruby_init_loadpath();
        if (argc > 0) {
	    const char *progname = argv[0];
	    ruby_script(progname);
	}
#if !__LP64__
	try {
#endif
	    void *self = rb_vm_top_self();
ruby_init_device_repl();
rb_define_global_const("RUBYMOTION_ENV", @"development");
rb_define_global_const("RUBYMOTION_VERSION", @"5.3");
MREP_907D1C9B40564185A8DB8A5E16B8869A(self, 0);
MREP_DEA03E667AD84FE9A81156602C5CFA66(self, 0);
MREP_CCDEC44DE5EC47548B00E9ACA8510C38(self, 0);
MREP_CA5809C415974850815CC545F8B50E61(self, 0);
MREP_08CA5C29A267405DB39BCD53AE4858FA(self, 0);
MREP_F8B65FF86F564988B4B939E33C627F67(self, 0);
MREP_572EA27C0FDC4B358C6264488B9D0591(self, 0);
MREP_33C46520B22044BFABE396A843175C52(self, 0);
MREP_E9404070CB7F4BB084D9499B8C13796E(self, 0);
MREP_A06ECB763A164A11B319650C98404D43(self, 0);
MREP_AF05B04A286840AE940C115F34AEF55E(self, 0);
MREP_86575CCFDB98407D92A4FDEF1DC0A838(self, 0);
MREP_7DE7FD7B05144701A7C68D6510CB4A25(self, 0);
MREP_173EBF25A55C48E5954A78BD16925E6E(self, 0);
MREP_9C766531FAEB4D6E962B0C3F016378E0(self, 0);
MREP_73A4CAD1CDAC40D9B9054BF87D416A7E(self, 0);
MREP_F8BACA700F2344D486CD4BD300609331(self, 0);
MREP_20715E96069C440DA2EC114C6E671955(self, 0);
MREP_326C77003FE0498DA71225C465B7CB8B(self, 0);
MREP_FD49B0D3FD92455EB16AD711C5C1BA0E(self, 0);
MREP_538B68DE04CF443188E8722383381566(self, 0);
MREP_AAD684A00BC04B1B9A94A292401DFB21(self, 0);
MREP_70717BC94ABB4212A71DD7B79370812F(self, 0);
MREP_C1BC00418B854188B25879B54965EBC0(self, 0);
MREP_3CC871CF113C43A98608A1BD7FB54644(self, 0);
MREP_7DC3925090E44D7F903CD70B91CFAC33(self, 0);
MREP_354EF2771DC64CCBA0C3E0FD440D2DE4(self, 0);
MREP_345D6756E8884BDA8C6378DB64FEE49F(self, 0);
MREP_667D9667EBD14B98B3363B795FF0CBC9(self, 0);
MREP_C272CA2F00BA49688EA605FBB357D2C9(self, 0);
MREP_331A815EAC69498DA69E4881CD0E152D(self, 0);
MREP_F4FA2A62E491488AB11FD58878A0409C(self, 0);
MREP_4BD0D6669C044919A728C798ABCDCCCF(self, 0);
MREP_25EAB40CF8D349EC8D4371A085C88A01(self, 0);
MREP_835D4B6EC35D43B69D9405451998269A(self, 0);
MREP_3D444055AC934E298D6EE14067214C61(self, 0);
MREP_2EF88B3BE769493CA25F8D87721D7986(self, 0);
MREP_D13380517BE049FAAA70DF107E5FA1D7(self, 0);
MREP_D282A3FE57514B0A97A18F88457EC04F(self, 0);
MREP_A412E80962564B7DB71A0857D110CCD6(self, 0);
MREP_C52BFF57F5584EABB9A61FA24FC31BDE(self, 0);
MREP_6BB22DC133DE4434BA45E21B948B47FC(self, 0);
MREP_E6B7A8F4E8F4412489CEE1C8F892580B(self, 0);
MREP_9EB95861E0044D2BA0227F9B32AF3DBD(self, 0);
MREP_A70677EB719F4271ACB898CA9AE30798(self, 0);
MREP_E21473363BBF4225B26F9E42CC80F2CC(self, 0);
MREP_177863A8076B415FA497D3050924C164(self, 0);
MREP_92D0B701848F426B8E8514550BFD92FA(self, 0);
MREP_0E5D569D635543E79541C07E56EF0F2A(self, 0);
MREP_3AD86C36193A4D93B5A39606317DB0CD(self, 0);
MREP_1CA5BB13803B48EF878C047E51320382(self, 0);
MREP_CE97296699E442B58ADDB9C5E6C010D0(self, 0);
MREP_887F496DACAA4A08BB602B80D0E86E49(self, 0);
MREP_279F9DCA58AC43F3B14C3F57B32DCB69(self, 0);
MREP_262A3B92E76A4C3B85DC4D7B0A64A65C(self, 0);
MREP_6C5AF4CA72584460B4BA4310A9A5E2D5(self, 0);
MREP_9B974DFDC4C74BB4B97AD8051E523CE7(self, 0);
MREP_0841EE22A74E43E8918D705F18DC8DC1(self, 0);
MREP_D39BBA79EE4B417AA0A9BFCACD7C3BF0(self, 0);
MREP_C073B59BCFB7412C92C0308F2FEF6E32(self, 0);
MREP_7802F4CC62AC4302A2225C16641A55E8(self, 0);
MREP_0A7D20FF9F174C9387F7F8EEB626565E(self, 0);
MREP_5DEA1813F5BF4149B9C58B599DFD02B4(self, 0);
MREP_124D46638CEC4ECB84F394377A1D165A(self, 0);
MREP_4D4366C04F294F7CBA106E69C57EB42C(self, 0);
MREP_18C9064F8DCA4F86AA0E37A2D2BFA90A(self, 0);
MREP_FA3CFA9E9AD34227B5386263CD63CD15(self, 0);
MREP_13827C88AB7E47CE843BB370A394F07D(self, 0);
MREP_905983B8F1C645E294B97BD79FB950C3(self, 0);
MREP_4759ED2444C64785B4046BAF23F35EA3(self, 0);
MREP_BD11ADC88E55412CA5D02ABC6BF8427A(self, 0);
MREP_E470867ECDAC4A59ACCE94BF186E4913(self, 0);
MREP_3E9C901467FE4FB3A5AF37BE37AAD48E(self, 0);
MREP_3E63B4EC5FFD40EA95E72D1529546A60(self, 0);
MREP_2C069B34BF2E431A8E0AFFCC9FADD9F3(self, 0);
MREP_265718AB34644AE5A6444DA4054918B5(self, 0);
MREP_47C7E41F1696414A936827F2C23CCB74(self, 0);
MREP_822029C810F44ADD8EB5BD02F42E376D(self, 0);
MREP_BEA7651CD0B541C28365317CA0DBF2E3(self, 0);
MREP_7DB963CA85B6487CA42CCB2B9271D93A(self, 0);
MREP_FB19DD4397F1438FB69CAFB71E581D85(self, 0);
MREP_F664C83956BB485BB6358F03BA6E5178(self, 0);
MREP_B209866F8412485289B3207E3E56CBFC(self, 0);
MREP_521B3CEDAE61469BA9D751B296355A0E(self, 0);
MREP_2418B877C88748FE9C70E8B8CC64A446(self, 0);
MREP_906C5054F8E14C9B9FFB9520917C520B(self, 0);
MREP_7B92380E780E4158AFC30376F1C710D3(self, 0);
MREP_A60A69C8ACE04A15B2B48DC73B35B1E2(self, 0);
MREP_6EC6C68C60124E53A19036B55FA51908(self, 0);
MREP_6FEF85A0BD9D4A98AF3B101F922846A3(self, 0);
MREP_ACE692312A874067B7ED1DBCFF1D0661(self, 0);
MREP_76B3F2AB22DC42B4B82858E684BC383A(self, 0);
MREP_05929AD2F342482798B943BC22BC1F63(self, 0);
MREP_580B58ED176C4FA485DB79539623E491(self, 0);
MREP_463CD98B51834A01A02B5AA002FA3AF5(self, 0);
MREP_8D7374A457D942F9856B3ADD6E6E4EB9(self, 0);
MREP_0C6675C690E34FB687B34A2F9ED8B9AB(self, 0);
#if !__LP64__
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
#endif
	initialized = true;
    }
}
