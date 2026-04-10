import 'package:flutter/material.dart';



class ResumeContent extends StatelessWidget {
  const ResumeContent({Key? key}) : super(key: key);

  static const Color sageGreen = Color(0xFFD4D6C3);
  static const Color darkGreen = Color(0xFF6B7C6E);
  static const Color goldBrown = Color(0xFFB4946F);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          color: sageGreen,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'JOHN DOE',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                  color: darkGreen,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ATTORNEY',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: darkGreen,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
        
        // Main Content
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection('CONTACT', const [
                        '4587 Main Street',
                        'Brooklyn, New York 48127',
                        '718.555.0100',
                        'johndoe@gmail.com',
                        'www.interestingsite.com',
                      ]),
                      const SizedBox(height: 28),
                      _buildSectionTitle('EDUCATION'),
                      const SizedBox(height: 12),
                      _buildEducationItem(
                        'JURIS DOCTOR • JUNE 20XX',
                        'Jasper University',
                        'Manhattan, NYC, New York',
                      ),
                      const SizedBox(height: 12),
                      _buildEducationItem(
                        'Real Estate Clinic',
                        '1st place in Moot Court',
                        '',
                      ),
                      const SizedBox(height: 12),
                      _buildEducationItem(
                        'BA IN POLITICAL SCIENCE',
                        'JUNE 20XX',
                        '',
                      ),
                      const SizedBox(height: 8),
                      _buildEducationItem(
                        'Mount Flores College',
                        'Small Town, Massachusetts',
                        '',
                      ),
                      const SizedBox(height: 28),
                      _buildSection('KEY SKILLS', const [
                        'Data analytics',
                        'Records search',
                        'Legal writing',
                        'Excellent communication',
                        'Organized',
                      ]),
                      const SizedBox(height: 28),
                      _buildSection('INTERESTS', const [
                        'Literature',
                        'Environmental conservation',
                        'Art',
                        'Yoga',
                        'Skiing',
                        'Travel',
                      ]),
                    ],
                  ),
                ),
              ),
              
              // Right Column
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('SUMMARY'),
                      const SizedBox(height: 12),
                      const Text(
                        'Detail-oriented and dynamic attorney with extensive experience in business and real estate law. Skilled in business formation, real estate transactions, distressed properties, due diligence, permitting, contract and lease negotiations, and landlord/tenant matters. Recognized for strong analytical abilities and energetic approach to complex legal issues.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.6,
                          color: darkGreen,
                        ),
                      ),
                      const SizedBox(height: 28),
                      _buildSectionTitle('WORK EXPERIENCE'),
                      const SizedBox(height: 16),
                      _buildWorkExperience(
                        'IN-HOUSE COUNSEL • MARCH 20XX — PRESENT',
                        'Banxter Real Estate • NYC, New York',
                        'For boutique real estate development firm, draft, negotiate and enforce leases and purchase & sale agreements. Negotiate purchase and sale contracts for residential and commercial properties including foreclosures. Handle landlord tenant issues, including leasing, eviction, and dispute resolution. Research, analyze and apply state and local environmental, land use and zoning laws in relation to real estate and business development in the Northeast. Oversee due diligence on potential real estate purchase opportunities. Work with outside counsel on litigation, permitting and other specialized firm-related legal matters.',
                      ),
                      const SizedBox(height: 20),
                      _buildWorkExperience(
                        'ASSOCIATE ATTORNEY • FEB 20XX — NOV 20XX',
                        'Luca Udinesi Law firm • NYC, New York',
                        'Represented and advised parties on small business, real estate, and landlord tenant issues. Researched and analyzed a wide range of legal issues. Represented client in a corporate dissolution litigation and won a \$25,000 supervised receivership and dissolution of corporation.',
                      ),
                      const SizedBox(height: 20),
                      _buildWorkExperience(
                        'JUNIOR ASSOCIATE ATTORNEY • SEPT 20XX — JAN 20XX',
                        'Law Offices of Katla Aoki • NYC, New York',
                        'Researched legal issues for senior counsel and assisted in representation of clients on a range of small business. Drafted legal memoranda. Second chair in a multi-million-dollar telecom litigation.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: goldBrown,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: darkGreen,
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildEducationItem(String title, String subtitle, String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: darkGreen,
          ),
        ),
        if (subtitle.isNotEmpty) const SizedBox(height: 4),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: darkGreen,
            ),
          ),
        if (location.isNotEmpty) const SizedBox(height: 2),
        if (location.isNotEmpty)
          Text(
            location,
            style: const TextStyle(
              fontSize: 11,
              color: darkGreen,
            ),
          ),
      ],
    );
  }

  Widget _buildWorkExperience(String title, String company, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: goldBrown,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          company,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            height: 1.6,
            color: darkGreen,
          ),
        ),
      ],
    );
  }
}